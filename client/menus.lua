sharedItems = QBCore.Shared.Items

RegisterNetEvent('rs-'..Config.Job..':client:OpenFood', function()
    local text = ''
    local FoodMenu = {}


  local FoodMenu = {
    {
      header = 'Food Menu',
      isMenuHeader = true,
    },
  }

  for k, v in pairs(Config.Food) do
    local item = {}
    local text = ""

    item.header = sharedItems[v.Item].label
    for r,s in pairs(v.Required) do
        text = text.. s.amount.."x "..sharedItems[s.item].label.."<br>"
    end
    item.header = sharedItems[v.Item].label
    item.text = text
    item.icon = v.Item
    item.params = {
        event = 'rs-'..Config.Job..':client:MakeFood',
        args = {
            item = v.Item,
            itemID = k,
            required = v.Required,
            emote = v.Emote
        }
    }

    table.insert(FoodMenu, item)
  end

    local CloseMenu = {
        header = 'Close Menu',
        icon = 'fas fa-x',
        params = {
            event = 'qb-menu:closeMenu'
        }
    }
    table.insert(FoodMenu, CloseMenu)

    exports['qb-menu']:openMenu(FoodMenu)
end)

RegisterNetEvent('rs-'..Config.Job..':client:OpenDrinks', function()
    local text = ''
    local DrinksMenu = {}


  local DrinksMenu = {
    {
      header = 'Drinks Menu',
      isMenuHeader = true,
    },
  }

  for k, v in pairs(Config.Drinks) do
    local item = {}
    local text = ""

    item.header = sharedItems[v.Item].label
    for r,s in pairs(v.Required) do
        text = text.. s.amount.."x "..sharedItems[s.item].label.."<br>"
    end
    item.header = sharedItems[v.Item].label
    item.text = text
    item.icon = v.Item
    item.params = {
        event = 'rs-'..Config.Job..':client:MakeDrink',
        args = {
            item = v.Item,
            itemID = k,
            required = v.Required,
            emote = v.Emote
        }
    }

    table.insert(DrinksMenu, item)
  end

    local CloseMenu = {
        header = 'Close Menu',
        icon = 'fas fa-x',
        params = {
            event = 'qb-menu:closeMenu'
        }
    }
    table.insert(DrinksMenu, CloseMenu)

    exports['qb-menu']:openMenu(DrinksMenu)
end)

RegisterNetEvent('rs-'..Config.Job..':client:OpenAlcohol', function()
    local text = ''
    local AlcoholMenu = {}


  local AlcoholMenu = {
    {
      header = 'Alcohol Menu',
      isMenuHeader = true,
    },
  }

  for k, v in pairs(Config.Alcohol) do
    local item = {}
    local text = ""

    item.header = sharedItems[v.Item].label
    for r,s in pairs(v.Required) do
        text = text.. s.amount.."x "..sharedItems[s.item].label.."<br>"
    end
    item.header = sharedItems[v.Item].label
    item.text = text
    item.icon = v.Item
    item.params = {
        event = 'rs-'..Config.Job..':client:MakeAlcohol',
        args = {
            item = v.Item,
            itemID = k,
            required = v.Required,
            emote = v.Emote
        }
    }

    table.insert(AlcoholMenu, item)
  end

    local CloseMenu = {
        header = 'Close Menu',
        icon = 'fas fa-x',
        params = {
            event = 'qb-menu:closeMenu'
        }
    }
    table.insert(AlcoholMenu, CloseMenu)

    exports['qb-menu']:openMenu(AlcoholMenu)
end)