# -*- coding: UTF-8 -*-

num = rand(1..10).to_i.to_s

Fabricator(:user) do
  full_name "John Q Public #{num}"
  email_address "jqp#{num}@public.com"
  user_name "johnpublic#{num}"
end

