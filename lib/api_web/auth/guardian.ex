defmodule ApiWeb.Auth.Guardian do
  use Guardian, otp_app: :api
  alias Api.Users.Services.UserCrud

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _), do: {:error, :no_id_provided}

  def resource_from_claims(%{"sub" => id}) do
    case UserCrud.get_user(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_), do: {:error, :no_id_provided}

  def authenticate(email, raw_password) do
    case UserCrud.get_user_by_email(email) do
      nil ->
        {:error, :unauthorized}

      user ->
        case validate_password(raw_password, user.password) do
          true -> create_token(user)
          false -> {:error, :unauthorized}
        end
    end
  end

  defp validate_password(raw_password, password) do
    Bcrypt.verify_pass(raw_password, password)
  end

  defp create_token(account) do
    {:ok, token, _claims} = encode_and_sign(account)
    {:ok, token}
  end
end
