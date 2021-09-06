package game.shaders;

import flixel.system.FlxAssets.FlxShader;

class OutlineShader extends FlxShader {
	public function update(elapsed:Float) {
		this.uTime.value[0] += elapsed;
	}

	@:glFragmentSource('
#pragma header

//time uniform
uniform float uTime;

void main(){
  vec4 color=flixel_texture2D(bitmap,openfl_TextureCoordv);
  float borderWidth=.025;
  
  if(color.a==0.){
    if(flixel_texture2D(bitmap,vec2(openfl_TextureCoordv.x+borderWidth,openfl_TextureCoordv.y)).a !=0.
    ||flixel_texture2D(bitmap,vec2(openfl_TextureCoordv.x-borderWidth,openfl_TextureCoordv.y)).a!=0.
    ||flixel_texture2D(bitmap,vec2(openfl_TextureCoordv.x,openfl_TextureCoordv.y+borderWidth)).a!=0.
    ||flixel_texture2D(bitmap,vec2(openfl_TextureCoordv.x,openfl_TextureCoordv.y-borderWidth)).a!=0.){

      //abs(sin(uTime)) - .5 
      //alpha channel does not work with frag Color?
      // alpha = vec4(abs(sin(uTime)) - .5);
      gl_FragColor=vec4(abs(sin(uTime)));//rgba color of empty pixel
    }else{
      gl_FragColor=color; // otherwise use regular color
    }
  }
  else{
    gl_FragColor=color;// RGB colors
  }
  
}

  ')
	public function new() {
		super();
		this.uTime.value = [0];
	}
}