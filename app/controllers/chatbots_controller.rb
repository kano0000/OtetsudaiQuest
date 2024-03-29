class ChatbotsController < ApplicationController

  protect_from_forgery

  def create
    input = params[:input]
    client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])
    # Define logic to generate response based on user input
    # https://platform.openai.com/docs/api-reference/chat/create
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", # Required. # 使用するGPT-3のエンジンを指定
        messages: [{ role: "system", content: "あなたは、子どもです。難しい言葉を使わずに回答します。そして、簡単な言葉でしか話すことはできません。" }, { role: "user", content: input }], # Required.
        temperature: 0.7, # 応答のランダム性を指定
        max_tokens: 200,  # 応答の長さを指定
      },
    )

    respond_to do |format|
      format.json { render json: { response: response.dig("choices", 0, "message", "content") } }
    end
  end

end
