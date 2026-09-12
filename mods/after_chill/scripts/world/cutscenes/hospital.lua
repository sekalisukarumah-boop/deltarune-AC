return {
    ---@param cutscene WorldCutscene
    patient0034 = function(cutscene) 
        local y = os.time() - 86400
        local formatted_date = os.date("%m/%d/%Y", y)
        cutscene:text("* [voice:sign]\"Patient 0034 -[wait:2] Entered the hospital at " .. formatted_date .. ".\"")
        cutscene:text("* [voice:sign]\"Condition - Influenza.\"")
        cutscene:text("* [voice:sign]\"Don't give constant care,[wait:2] occasional check ups.\"[wait:3] \n* \"Provide mediocre food.\"")
end 

}