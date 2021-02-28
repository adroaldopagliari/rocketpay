defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid -> returns an user" do
      params = %{
        name: "Adroaldo Pagliari",
        password: "123456",
        nickname: "adroaldo",
        email: "adroaldo@outlook.com.br",
        age: 32
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Adroaldo Pagliari", age: 32, id: ^user_id} = user
    end

    test "when there are invalid params -> returns an error" do
      params = %{
        name: "Adroaldo Pagliari",
        nickname: "adroaldo",
        email: "adroaldo@outlook.com.br",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_reponse = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_reponse
    end
  end
end
