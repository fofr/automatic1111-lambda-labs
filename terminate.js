import dotenv from 'dotenv'
import axios from 'axios'
dotenv.config()

const apiKey = process.env.LAMBDA_API_KEY
const apiUrl = 'https://cloud.lambdalabs.com/api/v1'

const terminateAllInstances = async () => {
  const headers = {
    'Content-Type': 'application/json',
    'Authorization': `Basic ${Buffer.from(apiKey + ':').toString('base64')}`,
  }

  try {
    const response = await axios.get(`${apiUrl}/instances`, { headers })
    const instances = response.data.data
    console.log(`Running instances: ${instances.length}`)
    for (const instance of instances) {
      console.log('Terminating running instance:', instance)
      const instanceId = instance.id
      const terminateInstanceResponse = await axios.post(`${apiUrl}/instance-operations/terminate`, {
        instance_ids: [instanceId]
      }, { headers })

      const terminatedInstances = terminateInstanceResponse.data.data.terminated_instances
      console.log('Terminated: ', terminatedInstances)
    }

    const checkForRunningInstances = await axios.get(`${apiUrl}/instances`, { headers })
    const runningInstances = checkForRunningInstances.data.data

    if (runningInstances.length > 0) {
      console.log('There are still running instances')
      console.log('runningInstances:', runningInstances)
    } else {
      console.log('All instances terminated')
    }
  } catch (error) {
    console.error('Error listing instances:', error)
  }
}

terminateAllInstances()
