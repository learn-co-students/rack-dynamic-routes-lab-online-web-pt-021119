class Application

    @@items= []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if !req.path.match(/items/)
            resp.write "Route not found"
            resp.status = 404
        else
            item_name = req.path.split("/items/").last
            item = @@items.find {|i| i.name == item_name}
            if item
                resp.write item.price
            else
                resp.write "Item not found"
                resp.status = 400
            end
        end

        resp.finish
    end

end