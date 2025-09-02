# Deployment Guide


game.Players.PlayerAdded:Connect(function(player)
    DataPersistence.loadPlayer(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
    DataPersistence.savePlayer(player)
end)


