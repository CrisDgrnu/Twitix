alias Api.Repo

alias Api.Users.Model.User

Repo.insert!(%User{
  email: "admin@admin.com",
  password: Bcrypt.hash_pwd_salt("admin_pass"),
  full_name: "Cristian de Gracia Nuero",
  biography: "Software Engineer",
  gender: :male
})
