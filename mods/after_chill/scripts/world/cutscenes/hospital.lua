return {
    ---@param cutscene WorldCutscene
    patient0034 = function(cutscene) 
        local y = os.time() - 86400
        local formatted_date = os.date("%m/%d/%Y", y)
        cutscene:text("* You read the sign.")
        cutscene:wait(0.25)
        cutscene:text("* \"Patient 0034 -[wait:2] Entered the hospital " .. formatted_date .. ".\"")
        cutscene:text("* \"Condition - Influenza.\"")
        cutscene:text("* \"Don't give constant care,[wait:2] occasional check ups.\"[wait:3] \n* \"Provide mediocre food.\"")
end 

}