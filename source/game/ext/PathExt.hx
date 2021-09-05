package game.ext;

import flixel.util.FlxPath;

inline function activePathNode(path:FlxPath):FlxPoint {
	var currentPoint = path.nodes[path.nodeIndex];
	return currentPoint;
}