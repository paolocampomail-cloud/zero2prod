use zero2prod::run;
use std::net::TcpListener;

#[tokio::main]
async fn main() -> std::io::Result<()> {
    // We bind to port 8000 for actual local running
    let listener = TcpListener::bind("127.0.0.1:8000")?;
    run(listener)?.await
}