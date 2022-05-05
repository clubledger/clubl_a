# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ClubLA.Repo.insert!(%ClubLA.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ClubLA.Accounts.User
alias ClubLA.Accounts.UserToken
alias ClubLA.Logs.Log
alias ClubLA.Accounts.UserSeeder

if Mix.env() == :dev do
  ClubLA.Repo.delete_all(Log)
  ClubLA.Repo.delete_all(UserToken)
  ClubLA.Repo.delete_all(User)

  UserSeeder.admin()
  UserSeeder.random_users(20)
end
