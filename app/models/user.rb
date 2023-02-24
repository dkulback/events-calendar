class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.access_token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.expires_at = auth.credentials.expires_at
    end
  end

  def access_token_expired?
    Time.now > Time.at(expires_at)
  end

  def refresh_access_token!
    response = Faraday.post('https://oauth2.googleapis.com/token',
                            {
                              client_id: ENV['GOOGLE_CLIENT_ID'],
                              client_secret: ENV['GOOGLE_CLIENT_SECRET'],
                              refresh_token: refresh_token,
                              grant_type: 'refresh_token'
                            })
    body = JSON.parse(response.body)
    update(access_token: body['access_token'], expires_at: Time.now + body['expires_in'].to_i)
  end
end
