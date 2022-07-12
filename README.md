<div id="top"></div>


<br />
<div align="center">


  <h3 align="center">Parker</h3>
  <p align="center">
  Alternative to phone number written on a piece of paper on car dashboard. Comes in the form of Flutter mobile application with Firebase services.
    <br />
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#todo">Todo</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<p align="center">
<img src="https://github.com/ChengCK18/parker-flutter/blob/main/readme_docs/p1.gif" alt="Login into main page"  height="600"/>
</p>

The main motivation for this project is from living in a town where parking spots are limited and double parkings are frequent events. Long car horn ensues to get the double parker's attention. 

This mobile application is meant to be a bridge for simple communication with other drivers (such as double parkers). The current version of the application provides the basic core functionality of "alerting" other drivers given only their number plate(provided they are registed on the application as well). This application requires registration with an email only which is not publicly visible, hence avoiding the need to share phone numbers with strangers for data privacy reasons.

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With


<b>Frontend</b>💻

* [Flutter](https://flutter.dev/)


<b>Backend</b>⚙️
* [Firebase](https://firebase.google.com/)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

Have Flutter installed. I used Android Studio emulator to test out the application.


<p align="right">(<a href="#top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

1. Sign up for an account on the platform. (Remember to verify the email after, check spam)
2. Login using registered account credentials.
3. Enter your own vehicle number plate and press the register button. (First button from left of the entry field)
4. [First glowing button from top] Tap it to switch between online/offline. On offline mode, you won't be able to see the alerts sent to the vehicle
<p align="center">
<img src="https://github.com/ChengCK18/parker-flutter/blob/main/readme_docs/p1.gif" alt="Login into main page"  height="600"/>
</p>



5. [Second glowing button from top] Tap it after entering the vehicle number plate of the other party to send alert to them.
<p align="center">
<img src="https://github.com/ChengCK18/parker-flutter/blob/main/readme_docs/p2.gif" alt="Alert other vehicle"  height="600"/>
</p>

6. [Cross button] If someone sent you an alert, the first glowing button will turn red. To acknowledge the alerts received, press the cross button to clear the alerts.
<p align="center">
<img src="https://github.com/ChengCK18/parker-flutter/blob/main/readme_docs/p3.gif" alt="Clear alert received"  height="600"/>
</p>
7. Voilà


<p align="right">(<a href="#top">back to top</a>)</p>


<!-- ROADMAP -->
## Todo

- [ ] Create system notification for user when there is incoming alert.
- [ ] More types of alerts for different events
- [ ] UI/UX improvements. (More noticable response for actions performed, et cetera)



<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing
Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License

<p align="right">(<a href="#top">back to top</a>)</p>
