import {promisify} from 'util';
const exec = promisify(require('child_process').exec);

export interface SSHConnection {
  username : String,
  host : String,
  password : String|null
}

export interface Project {
  path : String,
  url : String,
  clone : String,
  update : String,
  commit(comment:String) : String,
  rm : String
}

var myhost:SSHConnection = {
  username : 'pi',
  host : '192.168.254.14',
  password : null
}

function myproject(path, url) : Project {
  return {
    path : path,
    url : url,
    clone : `git clone ${url} ${path}`,
    update : 'git pull',
    commit : (comment) => `git commit -m \"${comment}\"`,
    rm : `rm -rf ${path}`
  }
}

async function run(cmd:String) : Promise<String> {
  try {
    const { stdout, stderr } = await exec(cmd);
    return stdout;
  } catch (err) {
    console.error(err);
    return err;
  }
}

/**
 * 
 * @param sshConnection the ssh endpoint
 * @param cmd the command to run
 */
async function runRemote(sshConnection:SSHConnection, cmd:String) {
  return run(ssh(sshConnection.username, sshConnection.host, cmd));
}

/**
 * Runs a command using the local context
 * @param cmd the command to run on the remote machine
 */
async function remote(cmd:String) {
  return runRemote(myhost, cmd);
}

function ssh(username, host, cmd) {
  return `ssh -oStrictHostKeyChecking=no ${username}@${host} "${cmd}"`
}

function gitClone() {
  return 'git clone https://github.com/lakowske/hawt-spot ~/.hawt-spot'
}

async function deploy() : Promise<Boolean> {
  
  console.log(await remote('hostname'));
  var p = myproject('~/.hawt-spot', 'https://github.com/lakowske/hawt-spot');
  console.log(await remote(p.rm));
  console.log(await remote(p.clone));
  console.log(await remote('ls ~/.hawt-spot'));  
  console.log(await remote('/sbin/iwconfig'));  
  
  return true;
}


deploy();


