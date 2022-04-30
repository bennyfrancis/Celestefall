# Celestefall - Move and Collide Platformer System for GameMaker 2.3

A parent based move and collide platformer system for GameMaker with moving solids. Based on [Celeste and TowerFall Physics](https://maddythorson.medium.com/celeste-and-towerfall-physics-d24bd2ae0fc5)

This system includes:
- Simple parenting system for easy implementation in your project
- Many actors simultaneously interacting with many moving solids
- Custom collision event definition

Bonus: Solids and actors can be customized to behave how you want! The demo project includes examples of a player actor and two different kinds of moving solids.


## Installation

- Drag and drop the yymps file into your project to import the parent objects and utility scripts. 
- Enable 'Compatibility Mode' for collisions in the Main Project Settings of your GameMaker project.


## Usage

- Set the parent object of your Solids to o_solid (eg: walls and moving platforms) or alternate behaving solid such as o_solid_oneway
- Set the parent object of your Actors to o_actor (eg: players and enemies)
- The default collision event for Solids is no collision
- The default collision event for Actors is to set the move speed to zero


### Implementation

Input the desired move distance and collision event into the provided move functions. 
Note that Solids must be moved before Actors (eg: Solids are moved in the Begin Step event, Actors are moved in the Step event), however these functions can also be called from anywhere to move an object as a one-time event.

```gml

move_x(xspd, collision_event());
move_y(yspd, collision_event());

```

To use the default collision event of the parent, omit the collision_event parameter. The default event can be overridden in the child object.

```gml

move_x(xspd);
move_y(yspd);

```

Default movement variables are provided, however the default variables for handling fractional movement should not be changed:

```gml

//these can be changed
xspd = 0;
yspd = 0;

//do not change these!
xspd_remainder = 0;
yspd_remainder = 0;
```

The o_actor parent includes a default Squash script in the event the actor object is crushed between two solids. The default event is empty and requires population or overriding within the child object. 
eg:

```gml

//In create event of player object (child of o_actor)
//override of parent squash function

function squash() {	
    instance_create_depth(x, y, -1, o_player_squash);
    instance_destroy(id);
}

```

The function determining whether an Actor is riding a Solid should only be overriden or modified with care. This function helps Solids move an Actor when carrying them (as opposed to pushing them). For example, a wall clinging check was added for the player actor in the demo project, while the other checks help ensure the system works as intended and should not be changed:

```gml

function is_riding(_solid) {
    //optional check for player wall clinging
    if (clinging && cling_inst == _solid.id) { return true };

    //actor is on top -- *do not modify*
    if (place_meeting(x, y+1, _solid)) { return true };
    //actor is underneath -- *do not modify*
    if (place_meeting(x, y-1, _solid) && sign(_solid.yspd) == 1) { return true };
    //actor is moving the same direction horizontally as a moving solid (moving faster than the solid) -- *do not modify*
    return (place_meeting(x+sign(_solid.xspd), y, _solid) && sign(xspd) == sign(_solid.xspd)); 
}	
  
```


## Support and Contribution

Feel free to reach out to me on Discord if you have questions, comments, or are interested in contributing to the proejct: 
bennyfrancis#6146


## Acknowledgements 

- obj_frog (colmeye) for helping optimize and refactor the system and for answering all my questions
- The awesome people on the GameMaker Discord for all their help and support
- Pixel Frog who created the free [Treasure Hunters asset pack](https://pixelfrog-assets.itch.io/treasure-hunters) available on itch.io
- Maddy Thorson for writing the article on Celeste and Towerfall physics


## Lisence

[MIT](https://choosealicense.com/licenses/mit/)




