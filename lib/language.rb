require 'base64'
require 'json'
require 'net/https'

module Language
  class << self
    def get_tags(text)
      # APIのURL作成
      api_url = "https://language.googleapis.com/v1/documents:analyzeSentiment?key=#{ENV['GOOGLE_API_KEY']}"
      # APIリクエスト用のJSONパラメータ
      params = {
        document: {
          type: 'PLAIN_TEXT',
          content: text
        }
      }.to_json
      # Google Cloud Natural Language APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      # APIレスポンス出力
      response_body = JSON.parse(response.body)
      if (error = response_body['error']).present?
        raise error['message']
      else
        get_tags(response_body)
      end  
    end
    
    def get_tags(response_body)
      # タグを抽出するロジック
      # 例: レスポンスから必要な情報を取得してタグを抽出
      tags = []
      entities = response_body['entities'] || []
      entities.map { |entity| entity['name'] }
    
    end
    
  end
end