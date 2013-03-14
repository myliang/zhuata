class User
  include MongoMapper::Document
  include MongoMapper::Paperclip

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  ##
  devise :database_authenticatable, :registerable, # :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  key :email,               String, required: true
  key :encrypted_password,  String

  ## extend information
  key :name, String , required: true, unique: true, length: {maximum: 16}
  key :real_name, String, length: {maximum: 20}
  key :location, String, length: {maximum: 20}
  key :website, String, length: {maximum: 50}
  key :bio, String, length: {maximum: 200}

  ## Recoverable
  key :reset_password_sent_at,  Time

  ## Rememberable
  key :remember_token, String
  key :remember_created_at,  Time

  ## Trackable
  key :sign_in_count,       Integer, default: 0
  key :current_sign_in_at,  Time
  key :last_sign_in_at,     Time
  key :current_sign_in_ip,  String
  key :last_sign_in_ip,     String

  ## Confirmable
  key :confirmation_token,    String
  key :confirmed_at,          Time
  key :confirmation_sent_at,  Time
  key :unconfirmed_email,     String # Only if using reconfirmable

  ## Lockable
  # key :failed_attempts,  Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # key :unlock_token,     String # Only if unlock strategy is :email or :both
  # key :locked_at,        Time

  ## Token authenticatable
  # key :authentication_token,  String

  # count
  key :unread_messages_count, Integer, default: 0
  # key :unread_comments_count, Integer, default: 0

  many :blogs
  many :comments

  many :send_messages, class_name: 'Message'
  many :receive_messages, class_name: 'Message'


  attr_accessor :password_confirmation, :current_password

  [:comments, :blogs, :fictions, :audio_books].each do |name|
    key "#{name}_count", Integer, default: 0
  end

  timestamps!

  has_mm_attached_file :avatar,
    default_style: :middle,
    styles: { medium: "240x240#", thumb: "120x120#",
              middle: "48x48#", small: "24x24#"},
              # :url => "upload/:class/:attachment/:hashed_path/:id_:style.:extendsion",
              url: "/upload/:class/:attachment/:id/:style.:extension",
              path: "#{Rails.root}/public/upload/:class/:attachment/:id/:style.:extension"
  # :default_url => ":style.jpg"

  validates_attachment_size :avatar, less_than: 2.megabyte # about 2 Mb
  # validates_attachment_content_type, :avatar, :content_type => 'image/jpeg'

  validate :website,
    format: {with: /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@\[\]\':+!]*([^\"\"])*$/, allow_blank: true}

  def update_with_password(params, *options)
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if valid_password?(current_password)
      update_attributes(params, *options)
    else
      params.each_pair { |k,v| send("#{k}=", v) if respond_to?("#{k}=") } if params
      self.valid?
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end
    clean_up_passwords
    result
  end

end
