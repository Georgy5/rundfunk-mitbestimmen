class User < ActiveRecord::Base

  enum role: { guest: -1, contributor: 0, broadcaster: 1, admin: 2 }

  has_many :selections
  has_many :liked_broadcasts, -> { where(selections: {response: 1}) }, :source => :broadcast , :through => :selections
  has_many :broadcasts, through: :selections

  before_validation do
    # allow bad emails but don't sent out mails
    self.has_bad_email ||= ValidEmail2::Address.new(email).disposable?
  end
  validates :email, uniqueness: true, if: 'email.present?'
  validates :auth0_uid, uniqueness: true, if: 'auth0_uid.present?'

  def self.from_token_payload(payload)
    if payload['sub'].blank?
      return nil
    else

      if payload['email'].present?
        legacy_user = self.find_by(email: payload['email'])
        if legacy_user
          if legacy_user.auth0_uid.blank?
            legacy_user.auth0_uid = payload['sub']
            legacy_user.save!
          end
          return legacy_user
        end
      end

      return self.find_or_create_by(auth0_uid: payload['sub'], email: payload['email'])
    end
  end
end
