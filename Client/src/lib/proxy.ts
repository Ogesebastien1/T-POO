export enum HttpMethod {
  GET = 'GET',
  POST = 'POST',
  PUT = 'PUT',
  DELETE = 'DELETE'
}

const { VITE_API_URL = 'https://api.timemanager.alexishenry.eu/api' } = import.meta.env

interface FetchParamsInterface {
  endpoint: string
  method?: HttpMethod
  payload?: any
  withToken?: boolean
}

export const fetch = async (params: FetchParamsInterface): Promise<Response> => {
  const { endpoint, method = HttpMethod.GET, payload, withToken = true } = params

  const headers = new Headers()

  if (withToken) {
    headers.set('Authorization', `Bearer ${localStorage.getItem('token')}`)
  }

  headers.set('Accept', 'application/json')
  headers.set('Content-Type', 'application/json')

  const options: RequestInit = {
    method,
    headers
  }

  if (payload && method !== HttpMethod.GET) {
    options.body = JSON.stringify(payload)
  }

  const response = await window.fetch(`${VITE_API_URL}${endpoint}`, options)

  return response
}
