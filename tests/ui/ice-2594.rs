#[derive(Copy, Clone, PartialEq, Debug)]
pub struct Header<'a> {
    pub name: &'a str,
    pub value: &'a [u8],
}

// TODO: Can I somehow trigger the ICE?
pub const EMPTY_HEADER: Header<'static> = Header { name: "", value: b"" };

fn main() {
    let txt = "something";
    match txt {
        "something" => {
            let mut headers = [EMPTY_HEADER; 10];
        }
        "" => (),
        _ => (),
    }
}
