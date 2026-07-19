// Games-lib/build.rs
use std::env;
use std::fs;
use std::path::Path;

fn main() {
    // Tell Cargo to rerun this script if any folder changes
    println!("cargo:rerun-if-changed=.");

    let out_dir = env::var_os("OUT_DIR").unwrap();
    let dest_path = Path::new(&out_dir).join("detected_games.rs");
    
    // Scan the repository directories
    let mut games = Vec::new();
    let entries = fs::read_dir(".").unwrap();

    for entry in entries {
        let entry = entry.unwrap();
        let path = entry.path();
        
        // Check if it's a directory and contains a Godot project file
        if path.is_dir() && path.join("project.godot").exists() {
            if let Some(folder_name) = path.file_name().and_then(|s| s.to_str()) {
                // Ignore hidden folders or build directories if necessary
                if !folder_name.starts_with('.') && folder_name != "target" && folder_name != "src" {
                    games.push(folder_name.to_string());
                }
            }
        }
    }

    // Generate the Rust code to be included in lib.rs
    let mut code = String::new();
    code.push_str("pub const GAMES: &[&str] = &[\n");
    for game in games {
        code.push_str(&format!("    \"{}\",\n", game));
    }
    code.push_str("];\n");

    fs::write(&dest_path, code).unwrap();
}