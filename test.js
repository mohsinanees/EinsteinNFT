const db = require("quick.db");

// db.set("Ghoulies", { currentid: 421, minted: [] });

async function run() {
    //   for (let i = 1, j = 1; i <= 10; i++) {
    //     for (; j <= i * 1000; j++) {
    //       db.push("Ghoulies.minted", j);
    //     }
    //     await new Promise((resolve) => setTimeout(resolve, 2000));
    //     let arr = db.get("Ghoulies.minted");

    //     console.log(arr.includes(5000));
    //   }
    let arr = [];
    for (let i = 1; i < 10001; i++) {
        arr.push(i);
    }
    //   await new Promise((resolve) => setTimeout(resolve, 2000));

    db.set("Ghoulies.minted", arr);
    arr = db.get("Ghoulies.minted");
    arr.splice(arr.indexOf(15), 5);
    //   console.log(arr[5002]);
    console.log(arr[15]);

    // console.log(db.has("Ghoulies.mintable[2]"));

    //   let arr = db.get("Ghoulies.minted");

    //   console.log(arr);
}

run();

// let arr = ["123", "nacjn", "83urdfj", "delete", "check"];
// arr.splice(3, 1);

// console.log(arr);

let arr = [
    "QmQJo8cSACAJFm5Wv6RUDC7hVJivDRe3qBnHTZTebdUK9E/16.json",
    "QmQJo8cSACAJFm5Wv6RUDC7hVJivDRe3qBnHTZTebdUK9E/17.json",
    "QmQJo8cSACAJFm5Wv6RUDC7hVJivDRe3qBnHTZTebdUK9E/18.json",
    "QmQJo8cSACAJFm5Wv6RUDC7hVJivDRe3qBnHTZTebdUK9E/19.json",
    "QmQJo8cSACAJFm5Wv6RUDC7hVJivDRe3qBnHTZTebdUK9E/20.json",
    "QmQJo8cSACAJFm5Wv6RUDC7hVJivDRe3qBnHTZTebdUK9E/21.json",
];
