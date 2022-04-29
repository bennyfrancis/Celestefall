# Celestefall - Move and Collide Platformer Engine
A parent based platformer move and collide engine with moving solids for GameMaker based on Celeste and Towerfall physics.

Calculate your move distances/speeds how you want and use the included move_x(xspd,collision_event) and move_y(yspd,collision_event) functions to move your solids and actors. It's that simple! No need for additional collision or movement code, however the system is easily customizable!

This engine includes:
- Simple parenting system for easy implementation in your project
- Many actors simultaneously interacting with many moving solids
- Custom collision event definition

Bonus: Solids and actors can be customized to behave how you want! The demo project includes an example of a player actor and two different kinds of moving solids as examples.

Notes:
- This method was created using GameMaker 2.3 and has not been tested in earlier versions. It currently uses the compatibility mode for collisions found in the Main Project Settings of GameMaker.
- Solids must run their move functions before Actors do. In other words Solids should run their move functions in the Begin Step event, while Actors run their move functions in the Step event.

Credit to Maddy Thorson for sharing the original article which has been adapted to work with GameMaker. Please refer to the article for a detailed explanation of how this approach works: 

https://maddythorson.medium.com/celeste-and-towerfall-physics-d24bd2ae0fc5


Please feel free to reach out to me on Discord if you have questions or comments: bennyfrancis#6146

Thanks!

bennyfrancis
