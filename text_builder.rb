require_relative 'api_processor'

class TextBuilder
  ACTIONS = ['start', 'table', 'results', 'fixtures', 'player_stats']

  def initialize(message)
    @message = message
  end

  def call
    send(action) if ACTIONS.include?(action)
  end

  private

  def action
    command = @message.text.include?('@') ? @message.text.match(/^(.*?)@/)[1] : @message.text
    command.gsub('/','')
  end

  def start
    text = "Hi, <b>#{@message.from.first_name}</b>!\n\n"
    text += "Here is everything you can do with me:\n\n"
    text += "/table - view tournament table\n"
    text += "/results - last closed tour results\n"
    text += "/fixtures - list of next tour matches\n"
    text + '/player_stats - show top players statistics'
  end

  def table
    text = "Tournament Table\n--------------------------------\n"
    text += "# | Team - Points (Goals diff)\n--------------------------------\n"
    response.each_with_index do |r, i|
      text += "#{i + 1} | <b>#{r['team_name']}</b> - #{r['points']} (#{r['goals_difference']})\n"
    end
    text
  end

  def results
    text = "Last Tour Results\n--------------------------------\n"
    response.each_with_index do |r, i|
      text += "Match ##{i + 1}\n"
      text += "<b>#{titleize(r.dig('host', 'name'))} | #{r.dig('host_goals')}</b> (#{r.dig('host_score')})\n"
      text += "<b>#{titleize(r.dig('guest', 'name'))} | #{r.dig('guest_goals')}</b> (#{r.dig('guest_score')})\n"
      text += "--------------------------------\n"
    end
    text
  end

  def fixtures
    "Fixtures\n--------------------------------\n (to be implemented later)"
  end

  def player_stats
    "Player Stats\n--------------------------------\n (to be implemented later)"
  end

  def response
    ApiProcessor.new(action).call
  end

  def titleize(string)
    string.tr('_', ' ').split.map(&:capitalize).join(' ')
  end
end
