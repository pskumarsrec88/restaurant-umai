class Restaurant < ApplicationRecord
  # Associations
  has_many :shifts, dependent: :destroy
  has_many :tables, dependent: :destroy
  has_many :reservations, dependent: :destroy

  # Validations
  # required field validation
  validates :name, :email, :phone_number, presence: true
  validates :name, uniqueness: true

  # Email format validation
  validates_format_of :email,
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/,
    unless: proc { |r| r.email.blank? }

  # Phone number format validations
  validates_format_of :phone_number,
    with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\Z/,
    unless: proc { |r| r.phone_number.blank? }

  # nested attributes for shift
  accepts_nested_attributes_for :shifts
  accepts_nested_attributes_for :tables

  # delegates
  delegate :name, :email, to: :guest, prefix: true

  # Response object
  def to_json
    {
      id: id,
      name: name,
      email: email,
      phone_number: phone_number,
      created_at: created_at,
      updated_at: updated_at,
      shifts: shifts,
      tables: tables
    }
  end

  def shifts_available(time)
    shifts.select { |shift| shift.shifts_available(time) }
  end
end
