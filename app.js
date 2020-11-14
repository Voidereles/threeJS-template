import * as THREE from './node_modules/three/build/three.module.js';
import fragment from './shaders/fragment.glsl';
import vertex from './shaders/vertex.glsl';

let OrbitControls = require("three-orbit-controls")(THREE);

export default class Sketch {
    constructor() {

        this.renderer = new THREE.WebGLRenderer({
            antialias: true
        });
        this.renderer.setSize(window.innerWidth, window.innerHeight);
        document.getElementById('container').appendChild(this.renderer.domElement);

        this.camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 1, 3000);
        this.camera.position.z = 1000;

        this.scene = new THREE.Scene();
        this.controls = new OrbitControls(this.camera, this.renderer.domElement);


        this.addMesh();
        this.render();
    }

    addMesh() {
        this.material = new THREE.ShaderMaterial({
            fragmentShader: fragment,
            vertexShader: vertex,
            uniforms: {
                progress: {
                    type: "f",
                    value: 0
                }
            },
            side: THREE.DoubleSide
        });

        let number = 512 * 512;
        // this.geometry = new THREE.PlaneBufferGeometry(1000, 1000, 10, 10);
        this.geometry = new THREE.BufferGeometry();

        this.positions = new THREE.BufferAttribute(new Float32Array(number * 3), 3);

        // this.material = new THREE.MeshNormalMaterial({
        //     side: THREE.DoubleSide
        // });
        let index = 0;
        for (let i = 0; i < 512; i++) {
            let posX = i - 256;
            for (let j = 0; j < 512; j++) {
                this.positions.setXYZ(index * 3, i * 2, (j - 256) * 2, 0);
                index++;
            }
        }

        this.geometry.setAttribute("position", this.positions);

        this.mesh = new THREE.Points(this.geometry, this.material);
        this.scene.add(this.mesh);
    }

    render() {
        this.time++;
        //rotation
        this.mesh.rotation.x += 0.01;
        this.mesh.rotation.y += 0.02;

        // console.log(this.time)

        this.renderer.render(this.scene, this.camera);
        window.requestAnimationFrame(this.render.bind(this));
    }
}

new Sketch();