class CounterReflex < ApplicationReflex
    def delete
        ele = List.find(element.dataset.id)
        ele.destroy
    end

    def changeurl
    url = "http://localhost:3000/lists/#{element.dataset.id}"
    cable_ready["resp"].dispatch_event(name:"customevent",selector:"#list_#{element.dataset.id}",detail:url).broadcast
    end

    def deleteItem
        ele = Item.find(element.dataset.id)
        ele.destroy
    end

    def clear
        cable_ready["resp"].set_value(selector:"#form-textfield",value:"")
        selector_all("#form-textfield").each do |element|
            element.set_attribute("value", "new value")
          end
    end
end
