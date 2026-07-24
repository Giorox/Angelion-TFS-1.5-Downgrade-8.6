function onStartup()
    -- Configure Waterskin of Mead Quset -> Make the waterskin have mead as it's liquid
    local barrel = Container(1315)  -- Get barrel of quest by it's unique ID
    local barrelItems = barrel:getItems()

    -- Check if the waterskin exists, if it does, set fluidtype to 43 (Mead)
    for _, item in pairs(barrelItems) do
        if item:getId() == 2031 then
            item:setAttribute("fluidtype", 43)
        end
    end

end