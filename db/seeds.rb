# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)
User.create!( name: "Guest User",
              email: "guest@email.com",
              password: "password",
              password_confirmation: "password",
              admin: false)