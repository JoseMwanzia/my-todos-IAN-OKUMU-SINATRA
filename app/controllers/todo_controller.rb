class TodoController < Sinatra::Base

 set :views, './app/views' # {OUR ERB FILE IS SUPPOSED   TO BE IN THE ROOT FOLDER,HOWEVER THIS CODE INDICATES THAT THE ERB FILE IS WITHIN APP}

    # before do 
    #     puts "HELLO, TO THIS ROUTE! !"
    # end

    # METHOD FOR CREATING A NEW TODOS IN THE DB.
    post '/todos/create' do
        begin
        # approach 1 (individual columns)
            # title = data["title"]
            # description = data["description"]
            # todo = Todo.create(title: title, description: description, createdAt: today)
            # todo.to_json
            
        # approach 2 (hash of columns)
            data = JSON.parse(request.body.read)
            today = Time.now
            data["createdAt"] = today
            todo =Todo.create(data)
        rescue => e
            [422, { error: e.message }.to_json]
        end
    end

    # METHOD FOR ACCESSNIG THE TODOS IN THE DB.
    get '/todos' do
        todos = Todo.all
        todos.to_json
    end

# RENDERS MY HTML FILE IN ERB 
get '/view/todos' do
        @todos = Todo.all # WRITTEN AS AN INSTANCE VARIABLE FOR THE ERB TO FIND IT 
        erb :todos #file name of the erb file  
end

    # method for updating database
    put '/todos/update/:id' do
        begin
            data = JSON.parse(request.body.read)
            todo = Todo.find(params[:id].to_i)
            # data.delete("createdAt")
            todo.update(data)
            {message: "Todo deleted succesfully"}.to_json
        rescue => e
            [422, { error: e.message }.to_json]
        end
    end

    # DELETE METHOD FOR DELETING IN DATABASE
    delete '/todos/destroy/:id' do
        begin
            todo = Todo.find(params[:id].to_i)
            todo.destroy
             {message: "Todo deleted succesfully"}.to_json
        rescue => e
            [422, { error: e.message }.to_json]
        end
    end
end