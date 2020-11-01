module ApplicationHelper

  def full_url(path)
    domain = if Rails.env.development?
             'http://localhost:3000'
           else
             'https://dande.work'
           end
    "#{domain}#{path}"
  end

end
