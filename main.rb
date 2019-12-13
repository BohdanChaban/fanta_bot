require 'telegram/bot'
require_relative 'messenger'

TOKEN = '809115124:AAEz_CU1RAVYKnph70d0_mmsQae-VrfXjOw'

p 'FantaBot is started'

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    Messenger.new(bot, message).call
  end
end
