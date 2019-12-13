require_relative 'text_builder'

class Messenger
  def initialize(bot, message)
    @bot = bot
    @message = message
  end

  def call
    @bot.api.send_message(chat_id: @message.chat.id, text: text, parse_mode: 'html')
  end

  private

  def text
    TextBuilder.new(@message).call
  end
end
