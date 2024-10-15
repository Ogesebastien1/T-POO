export enum HttpMethod {
  GET = 'GET',
  POST = 'POST',
  PUT = 'PUT',
  DELETE = 'DELETE'
}

const { VITE_API_URL } = import.meta.env

export const fetch = async ({
  endpoint,
  method,
  payload,
  withToken
}: {
  endpoint: string
  method: HttpMethod
  payload?: any
  withToken: boolean
}): Promise<Response> => {
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
