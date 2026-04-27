import client from './client'

export interface LoginPayload {
  username: string
  password: string
}

export interface User {
  id: number
  username: string
  email: string
}

export interface LoginResponse {
  token: string
  user: User
}

export const login = (data: LoginPayload) =>
  client.post<LoginResponse>('/auth/login/', data)

export const logout = () =>
  client.post('/auth/logout/')

export const me = () =>
  client.get<User>('/auth/me/')
