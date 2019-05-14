class Application

    @@items = []

    def call(env)
        req = Rack::Request.new(env)
        resp = Rack::Response.new
        if req.path.match(/item/)
            item = req.path.split("/items/").last
            # binding.pry
            if !!Item.find_by_name(item)
                resp.write Item.find_by_name(item).price
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.status = 404
            resp.write "Route not found"
        end
        resp.finish
    end

end