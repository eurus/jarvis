role :app, %w{username@your_server}
server 'your_server',
  user: 'username',
  roles: %w{app},
  ssh_options: {
    forward_agent: true,
    auth_methods: %w(password),
    password: 'your_password'
}
