import dotenv from 'dotenv'
import axios from 'axios'
import { exec } from 'child_process'
dotenv.config()

const apiKey = process.env.LAMBDA_API_KEY
const ssh_key_name = process.env.SSH_KEY_NAME
const ssh_private_key_path = process.env.SSH_PRIVATE_KEY_PATH
const apiUrl = 'https://cloud.lambdalabs.com/api/v1'

const headers = {
  'Content-Type': 'application/json',
  'Authorization': `Basic ${Buffer.from(apiKey + ':').toString('base64')}`,
}

const runShellCommand = (command) => {
  return new Promise((resolve, reject) => {
    exec(command, (error, stdout, stderr) => {
      if (error) {
        reject(error)
      } else if (stderr) {
        reject(new Error(stderr))
      } else {
        resolve(stdout)
      }
    })
  })
}

const run = async (instanceId) => {
  // keep polling instance ID until there is an instance that is running with an IP
  let instance = null
  console.log(`Polling instance ${instanceId}...`)
  while (!instance || !instance.ip || !instance.status == 'running') {
    const response = await axios.get(`${apiUrl}/instances/${instanceId}`, { headers })
    instance = response.data.data
    await new Promise(resolve => setTimeout(resolve, 1000))
  }
  console.log('Instance is running with IP:', instance.ip)
  console.log('Running deploy-and-run.sh')
  runShellCommand(`./deploy-and-run.sh ${instance.ip} ${ssh_private_key_path} >> output.log 2>&1`)
}

const findAndStartInstance = async () => {
  try {
    // List instances
    const response = await axios.get(`${apiUrl}/instance-types`, { headers })
    const types = response.data.data
    const gpu1xA10 = types['gpu_1x_a10']

    if (gpu1xA10 && gpu1xA10.regions_with_capacity_available.length > 0) {
      console.log('Starting gpu_1x_a10 instance...')
      const region = gpu1xA10.regions_with_capacity_available[0]
      const region_name = region.name
      const startInstanceResponse = await axios.post(`${apiUrl}/instance-operations/launch`, {
        instance_type_name: 'gpu_1x_a10',
        region_name,
        ssh_key_names: [ssh_key_name]
      }, { headers })

      if (startInstanceResponse.status === 200) {
        console.log('Instance started successfully')
        const instanceId = startInstanceResponse.data.data.instance_ids[0]
        const instance = await axios.get(`${apiUrl}/instances/${instanceId}`, { headers })
        const instanceData = instance.data.data
        console.log('IP:', instanceData.ip)
        console.log('Status:', instanceData.status)

        run(instanceId)
      } else {
        console.error('Error starting instance', startInstanceResponse)
        return
      }
    }
  } catch (error) {
    console.error('Error listing instances:', error)
  }
}

findAndStartInstance()
