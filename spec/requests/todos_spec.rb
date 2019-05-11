require 'rails_helper'

RSpec.describe 'Todo API', type: :request do
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }
  #
  describe 'GET /todos' do
    before { get '/todos' }

    # get '/todos'を叩いた時にレコードが空ではなく、10個存在する事を確認する
    it 'レコードが空でないかつ、10個存在する' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    # get 'todos'を叩いた時にステータスコード200を返す
    it 'httpステータス200を返す' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}" }

    context 'レコードが存在する時' do
      it 'todoを返す' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end
      it 'ステータスコード200を返す事' do
        expect(response).to have_http_status(200)
      end
    end
    context 'レコードが存在しない時' do
      let(:todo_id) { 100 }
      it 'ステータスコード 404を返す事' do
        expect(response).to have_http_status(404)
      end

      it '見つからない時に"Couldn\'t find Todo"を返す' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'POST /todos' do
    let(:valid_attribute) { {title: 'Learn Elm', created_by: '1' } }
    context '有効なリクエストである時' do
      before { post '/todos', params: valid_attributes }
      it 'todoを作成した時タイトルが想定したものである事' do
        expect(json['title']).to eq('Learn Elm')
      end
      it 'ステータスコード201を返す' do
        expect(response).to have_http_status(201)
      end
    end

    context '無効なリクエストである時' do
      # created_byが無い為エラーが出る
      before { post '/todos', params: { title: 'Foobar' } }

      it 'ステータスコード422を返す事' do
        expect(response).to have_http_status(422)
      end
      it '正しいバリデーションエラーメッセージを返す事' do
        expect(response.body).to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/todo/#{todo_id}", params: valid_attributes }

      it 'レコードを更新する' do
        expect(response.body).to be_empty
      end

      it 'ステータスコード204を返す事' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}" }

    it 'ステータスコード204を返す事' do
      expect(response).to have_http_status(204)
    end
  end
end

