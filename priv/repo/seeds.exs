alias Api.Repo

alias Api.Accounts.Model.Account
alias Api.Users.Model.User

%Account{id: account_id} =
  Repo.insert!(%Account{
    email: "cris@dev.com",
    hash_password: "super,_.secret!-#_pass"
  })

Repo.insert!(%User{
  account_id: account_id,
  full_name: "Cristian de Gracia Nuero",
  biography: "Software Engineer",
  gender: :male
})
