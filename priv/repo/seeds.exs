alias Api.Repo

alias Api.Users.Model.User

Repo.insert!(%User{
  email: "cris@dev.com",
  hash_password: "super,_.secret!-#_pass",
  full_name: "Cristian de Gracia Nuero",
  biography: "Software Engineer",
  gender: :male
})
