//////////////////////////////////////////////////////////////////////////////////////
// Ghost class

// modes representing the ghost's current state
var GHOST_OUTSIDE = 0;
var GHOST_EATEN = 1;
var GHOST_GOING_HOME = 2;
var GHOST_ENTERING_HOME = 3;
var GHOST_PACING_HOME = 4;
var GHOST_LEAVING_HOME = 5;

// Ghost constructor
var Ghost = function() {
    // inherit data from Actor
    Actor.apply(this);

    this.randomScatter = false;
    this.faceDirEnum = this.dirEnum;
};

// inherit functions from Actor class
Ghost.prototype = newChildObject(Actor.prototype);

// displacements for ghost bouncing
Ghost.prototype.getBounceY = (function(){

    // NOTE: The bounce animation assumes an actor is moving in straight
    // horizontal or vertical lines between the centers of each tile.
    //
    // When moving horizontal, bounce height is a function of x.
    // When moving vertical, bounce height is a function of y.

    var bounceY = {};

    // map y tile pixel to new y tile pixel
    bounceY[DIR_UP] =    [-4,-2,0,2,4,3,2,3];
    bounceY[DIR_DOWN] =  [3,5,7,5,4,5,7,8];

    // map x tile pixel to y tile pixel
    bounceY[DIR_LEFT] =  [2,3,3,4,3,2,2,2];
    bounceY[DIR_RIGHT] = [2,2,3,4,3,3,2,2];

    return function(px,py,dirEnum) {
        if (px == undefined) {
            px = this.pixel.x;
        }
        if (py == undefined) {
            py = this.pixel.y;
        }
        if (dirEnum == undefined) {
            dirEnum = this.dirEnum;
        }

        if (this.mode != GHOST_OUTSIDE || !this.scared || gameMode != GAME_COOKIE) {
            return py;
        }

        var tilePixel = this.getTilePixel({x:px,y:py});
        var tileY = Math.floor(py / tileSize);
        var y = tileY*tileSize;

        if (dirEnum == DIR_UP || dirEnum == DIR_DOWN) {
            y += bounceY[dirEnum][tilePixel.y];
        }
        else {
            y += bounceY[dirEnum][tilePixel.x];
        }

        return y;
    };
})();

Ghost.prototype.getAnimFrame = function(frames) {
    if (frames == undefined) {
        frames = this.frames;
    }
    return Math.floor(frames/8)%2; // toggle frame every 8 ticks
};

// reset the state of the ghost on new level or level restart
Ghost.prototype.reset = function() {

    // signals
    this.sigReverse = false;
    this.sigLeaveHome = false;

    // modes
    this.mode = this.startMode;
    this.scared = false;

    this.savedSigReverse = {};
    this.savedSigLeaveHome = {};
    this.savedMode = {};
    this.savedScared = {};
    this.savedElroy = {};
    this.savedFaceDirEnum = {};

    // call Actor's reset function to reset position and direction
    Actor.prototype.reset.apply(this);

    // faceDirEnum  = direction the ghost is facing
    // dirEnum      = direction the ghost is moving
    // (faceDirEnum represents what dirEnum will be once the ghost reaches the middle of the tile)
    this.faceDirEnum = this.dirEnum;
};

Ghost.prototype.save = function(t) {
    this.savedSigReverse[t] = this.sigReverse;
    this.savedSigLeaveHome[t] = this.sigLeaveHome;
    this.savedMode[t] = this.mode;
    this.savedScared[t] = this.scared;
    if (this == blinky) {
        this.savedElroy[t] = this.elroy;
    }
    this.savedFaceDirEnum[t] = this.faceDirEnum;
    Actor.prototype.save.call(this,t);
};

Ghost.prototype.load = function(t) {
    this.sigReverse = this.savedSigReverse[t];
    this.sigLeaveHome = this.savedSigLeaveHome[t];
    this.mode = this.savedMode[t];
    this.scared = this.savedScared[t];
    if (this == blinky) {
        this.elroy = this.savedElroy[t];
    }
    this.faceDirEnum = this.savedFaceDirEnum[t];
    Actor.prototype.load.call(this,t);
};

// indicates if we slow down in the tunnel
Ghost.prototype.isSlowInTunnel = function() {
    // special case for Ms. Pac-Man (slow down only for the first three levels)
    if (gameMode == GAME_MSPACMAN || gameMode == GAME_OTTO || gameMode == GAME_COOKIE)
        return level <= 3;
    else
        return true;
};

// gets the number of steps to move in this frame
Ghost.prototype.getNumSteps = function() {

    var pattern = STEP_GHOST;

    if (this.mode == GHOST_GOING_HOME || this.mode == GHOST_ENTERING_HOME)
        return 2;
    else if (this.mode == GHOST_LEAVING_HOME || this.mode == GHOST_PACING_HOME)
        return this.getStepSizeFromTable(1, STEP_GHOST_TUNNEL);
    else if (map.isTunnelTile(this.tile.x, this.tile.y) && this.isSlowInTunnel())
        pattern = STEP_GHOST_TUNNEL;
    else if (this.scared)
        pattern = STEP_GHOST_FRIGHT;
    else if (this.elroy == 1)
        pattern = STEP_ELROY1;
    else if (this.elroy == 2)
        pattern = STEP_ELROY2;

    return this.getStepSizeFromTable(level ? level : 1, pattern);
};

// signal ghost to reverse direction after leaving current tile
Ghost.prototype.reverse = function() {
    this.sigReverse = true;
};

// signal ghost to go home
// It is useful to have this because as soon as the ghost gets eaten,
// we have to freeze all the actors for 3 seconds, except for the
// ones who are already traveling to the ghost home to be revived.
// We use this signal to change mode to GHOST_GOING_HOME, which will be
// set after the update() function is called so that we are still frozen
// for 3 seconds before traveling home uninterrupted.
Ghost.prototype.goHome = function() {
    this.mode = GHOST_EATEN;
};

// Following the pattern that state changes be made via signaling (e.g. reversing, going home)
// the ghost is commanded to leave home similarly.
// (not sure if this is correct yet)
Ghost.prototype.leaveHome = function() {
    this.sigLeaveHome = true;
};

// function called when pacman eats an energizer
Ghost.prototype.onEnergized = function() {

    this.reverse();

    // only scare me if not already going home
    if (this.mode != GHOST_GOING_HOME && this.mode != GHOST_ENTERING_HOME) {
        this.scared = true;
        this.targetting = undefined;
    }
};

// function called when this ghost gets eaten
Ghost.prototype.onEaten = function() {
    this.goHome();       // go home
    this.scared = false; // turn off scared
};

// move forward one step
Ghost.prototype.step = function() {
    this.setPos(this.pixel.x+this.dir.x, this.pixel.y+this.dir.y);
    return 1;
};

// ghost home-specific path steering
Ghost.prototype.homeSteer = (function(){

    // steering functions to execute for each mode
    var steerFuncs = {};

    steerFuncs[GHOST_GOING_HOME] = function() {
        // at the doormat
        if (this.tile.x == map.doorTile.x && this.tile.y == map.doorTile.y) {
            this.faceDirEnum = DIR_DOWN;
            this.targetting = false;
            // walk to the door, or go through if already there
            if (this.pixel.x == map.doorPixel.x) {
                this.mode = GHOST_ENTERING_HOME;
                this.setDir(DIR_DOWN);
                this.faceDirEnum = this.dirEnum;
            }
            else {
                this.setDir(DIR_RIGHT);
                this.faceDirEnum = this.dirEnum;
            }
        }
    };

    steerFuncs[GHOST_ENTERING_HOME] = function() {
        if (this.pixel.y == map.homeBottomPixel) {
            // revive if reached its seat
            if (this.pixel.x == this.startPixel.x) {
                this.setDir(DIR_UP);
                this.mode = this.arriveHomeMode;
            }
            // sidestep to its seat
            else {
                this.setDir(this.startPixel.x < this.pixel.x ? DIR_LEFT : DIR_RIGHT);
            }
            this.faceDirEnum = this.dirEnum;
        }
    };

    steerFuncs[GHOST_PACING_HOME] = function() {
        // head for the door
        if (this.sigLeaveHome) {
            this.sigLeaveHome = false;
            this.mode = GHOST_LEAVING_HOME;
            if (this.pixel.x == map.doorPixel.x)
                this.setDir(DIR_UP);
            else
                this.setDir(this.pixel.x < map.doorPixel.x ? DIR_RIGHT : DIR_LEFT);
        }
        // pace back and forth
        else {
            if (this.pixel.y == map.homeTopPixel)
                this.setDir(DIR_DOWN);
            else if (this.pixel.y == map.homeBottomPixel)
                this.setDir(DIR_UP);
        }
        this.faceDirEnum = this.dirEnum;
    };

    steerFuncs[GHOST_LEAVING_HOME] = function() {
        if (this.pixel.x == map.doorPixel.x) {
            // reached door
            if (this.pixel.y == map.doorPixel.y) {
                this.mode = GHOST_OUTSIDE;
                this.setDir(DIR_LEFT); // always turn left at door?
            }
            // keep walking up to the door
            else {
                this.setDir(DIR_UP);
            }
            this.faceDirEnum = this.dirEnum;
        }
    };

    // return a function to execute appropriate steering function for a given ghost
    return function() { 
        var f = steerFuncs[this.mode];
        if (f)
            f.apply(this);
    };

})();

// special case for Ms. Pac-Man game that randomly chooses a corner for blinky and pinky when scattering
Ghost.prototype.isScatterBrain = function() {
    var scatter = false;
    if (ghostCommander.getCommand() == GHOST_CMD_SCATTER) {
        if (gameMode == GAME_MSPACMAN || gameMode == GAME_COOKIE) {
            scatter = (this == blinky || this == pinky);
        }
        else if (gameMode == GAME_OTTO) {
            scatter = true;
        }
    }
    return scatter;
};

// determine direction
Ghost.prototype.steer = function() {

    var dirEnum;                         // final direction to update to
    var openTiles;                       // list of four booleans indicating which surrounding tiles are open
    var oppDirEnum = rotateAboutFace(this.dirEnum); // current opposite direction enum
    var actor;                           // actor whose corner we will target

    // special map-specific steering when going to, entering, pacing inside, or leaving home
    this.homeSteer();

    // current opposite direction enum
    oppDirEnum = rotateAboutFace(this.dirEnum); 

    // only execute rest of the steering logic if we're pursuing a target tile
    if (this.mode != GHOST_OUTSIDE && this.mode != GHOST_GOING_HOME) {
        this.targetting = false;
        return;
    }

    // AT MID-TILE (update movement direction)
    if (this.distToMid.x == 0 && this.distToMid.y == 0) {

        // trigger reversal
        if (this.sigReverse) {
            this.faceDirEnum = oppDirEnum;
            this.sigReverse = false;
        }

        // commit previous direction
        this.setDir(this.faceDirEnum);
    }
    // JUST PASSED MID-TILE (update face direction)
    else if (
            this.dirEnum == DIR_RIGHT && this.tilePixel.x == midTile.x+1 ||
            this.dirEnum == DIR_LEFT  && this.tilePixel.x == midTile.x-1 ||
            this.dirEnum == DIR_UP    && this.tilePixel.y == midTile.y-1 ||
            this.dirEnum == DIR_DOWN  && this.tilePixel.y == midTile.y+1) {

        // get next tile
        var nextTile = {
            x: this.tile.x + this.dir.x,
            y: this.tile.y + this.dir.y,
        };

        // get tiles surrounding next tile and their open indication
        openTiles = getOpenTiles(nextTile, this.dirEnum);

        if (this.scared) {
            // choose a random turn
            dirEnum = Math.floor(Math.random()*4);
            while (!openTiles[dirEnum])
                dirEnum = (dirEnum+1)%4; // look at likelihood of random turns
            this.targetting = false;
        }
        else {

            /* SET TARGET */

            // target ghost door
            if (this.mode == GHOST_GOING_HOME) {
                this.targetTile.x = map.doorTile.x;
                this.targetTile.y = map.doorTile.y;
            }
            // target corner when scattering
            else if (!this.elroy && ghostCommander.getCommand() == GHOST_CMD_SCATTER) {

                actor = this.isScatterBrain() ? actors[Math.floor(Math.random()*4)] : this;

                this.targetTile.x = actor.cornerTile.x;
                this.targetTile.y = actor.cornerTile.y;
                this.targetting = 'corner';
            }
            // use custom function for each ghost when in attack mode
            else {
                this.setTarget();
            }

            /* CHOOSE TURN */

            var dirDecided = false;
            if (this.mode == GHOST_GOING_HOME && map.getExitDir) {
                // If the map has a 'getExitDir' function, then we are using
                // a custom algorithm to choose the next direction.
                // Currently, procedurally-generated maps use this function
                // to ensure that ghosts can return home without looping forever.
                var exitDir = map.getExitDir(nextTile.x,nextTile.y);
                if (exitDir != undefined && exitDir != oppDirEnum) {
                    dirDecided = true;
                    dirEnum = exitDir;
                }
            }

            if (!dirDecided) {
                // Do not constrain turns for ghosts going home. (thanks bitwave)
                if (this.mode != GHOST_GOING_HOME) {
                    if (map.constrainGhostTurns) {
                        // edit openTiles to reflect the current map's special contraints
                        map.constrainGhostTurns(nextTile, openTiles, this.dirEnum);
                    }
                }

                // choose direction that minimizes distance to target
                dirEnum = getTurnClosestToTarget(nextTile, this.targetTile, openTiles);
            }
        }

        // Point eyeballs to the determined direction.
        this.faceDirEnum = dirEnum;
    }
};

Ghost.prototype.getPathDistLeft = function(fromPixel, dirEnum) {
    var distLeft = tileSize;
    var pixel = this.getTargetPixel();
    if (this.targetting == 'pacman') {
        if (dirEnum == DIR_UP || dirEnum == DIR_DOWN)
            distLeft = Math.abs(fromPixel.y - pixel.y);
        else {
            distLeft = Math.abs(fromPixel.x - pixel.x);
        }
    }
    return distLeft;
};

Ghost.prototype.setTarget = function() {
    // This sets the target tile when in chase mode.
    // The "target" is always Pac-Man when in this mode,
    // except for Clyde.  He runs away back home sometimes,
    // so the "targetting" parameter is set in getTargetTile
    // for Clyde only.

    this.targetTile = this.getTargetTile();

    if (this != clyde) {
        this.targetting = 'pacman';
    }
};
