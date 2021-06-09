
require 'mail'
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    begin
      m = Mail::Address.new(value)
      # We must check that value contains a domain, the domain has at least
      # one '.' and that value is an email address

      able_domain = lambda do |email = m|
        public_domains = %w[yahoo gmail outlook hotmail bol msn]
        public_domains.include? email.domain.split('.').first
      end

      r = m.domain.present? && m.domain.match('\.') && !able_domain.call && m.address == value

      # Update 2015-Mar-24
      # the :tree method was private and is no longer available.
      # t = m.__send__(:tree)
      # We need to dig into treetop
      # A valid domain must have dot_atom_text elements size > 1
      # employees@localhost is excluded
      # treetop must respond to domain
      # We exclude valid email values like <employees@localhost.com>
      # Hence we use m.__send__(tree).domain
      # r &&= (t.domain.dot_atom_text.elements.size > 1)
    rescue
      r = false
    end
    record.errors[attribute] << (options[:message] || 'é inválido') unless r
  end
end
