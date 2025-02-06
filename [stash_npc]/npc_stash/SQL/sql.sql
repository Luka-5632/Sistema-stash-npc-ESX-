CREATE TABLE IF NOT EXISTS `saved_items` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `player_id` INT NOT NULL,                  -- Player's unique identifier
    `npc_name` VARCHAR(50) NOT NULL,            -- Name of the NPC
    `item_name` VARCHAR(50) NOT NULL,           -- Name of the item
    `item_count` INT NOT NULL DEFAULT 1,        -- Count of items received
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_player_item_npc` (`player_id`, `npc_name`, `item_name`), -- Ensure uniqueness per NPC and item for each player
    FOREIGN KEY (`player_id`) REFERENCES `users`(`id`) ON DELETE CASCADE          -- Assumes a `users` table for players
);
