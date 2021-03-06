require 'digest/sha1'
require 'md5'
class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_many :comments, :as => :commentable
  has_many :comments
  # Virtual attribute for the unencrypted password
  attr_accessor :password
  
  liquid_methods :login, :email

  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  before_save :encrypt_password
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation
  
  class << self
    attr_accessor :current_user
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
  
  def role_check( logicstring )
    Caboose::RoleHandler.new.process( logicstring, :user => self)
  end
  def is_admin?
    login == 'root' || roles.map(&:title).include?('admin')
  end
  
  def gravatar_url( options = {} )
    options = {
      :rating => 'g',
      :size => '80'
    }.merge(options || {})
    parameters = {
      'r' => options[:rating].to_s,
      's' => options[:size].to_s
    }.map{|k,v| v.empty? ? nil : [k,v].join('=')}.compact.join('&')
    @gravatar_encoded_email ||= MD5::md5(self.email.downcase).to_s
    gravatar_url = "http://www.gravatar.com/avatar/"
    gravatar_url+@gravatar_encoded_email+(parameters.empty? ? '' : "?#{parameters}")
  end
  
  def gravatar( options = {} )
    html_options = options.delete(:options) || {}
    html_options[:src] = self.gravatar_url(options)
    html_options[:alt] ||= ''
    ActionController::Base.helpers.tag( 'img',
      html_options, false, false )
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    
    
end
