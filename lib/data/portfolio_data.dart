import 'package:flutter/material.dart';
import '../core/constants/app_icons.dart';
import '../models/project.dart';
import '../models/experience.dart';
import '../models/skill.dart';
import '../models/service.dart';

class PortfolioData {
  static const String name = "Kheamesh Soni";
  static const String role = "Flutter Developer | Mobile & Web Application Developer";
  static const String shortIntro = "Building scalable, beautiful and high-performance applications with Flutter.";
  static const String aboutSummary = "I am a passionate Flutter Developer with a strong foundation in building cross-platform applications. My focus is on creating clean, intuitive user experiences and writing maintainable, high-quality code. I love solving complex problems and turning ideas into reality through technology.";
  
  static const String experienceYears = "2+";
  static const String projectsCompleted = "15+";
  static const String technologiesCount = "10+";
  static const String clientsServed = "5+";

  static final List<Experience> experiences = [
    Experience(
      company: "Tech Solutions Inc.",
      role: "Senior Flutter Developer",
      duration: "2024 — Present",
      location: "Remote",
      responsibilities: [
        "Developed production-ready Flutter applications for high-traffic clients",
        "Integrated complex REST APIs and optimized network calls using Dio",
        "Implemented responsive UI that works seamlessly across all screen sizes",
        "Utilized GetX for robust state management and navigation control",
        "Mentored junior developers and conducted thorough code reviews"
      ],
      technologies: ["Flutter", "Dart", "GetX", "REST API", "Firebase"],
      achievements: [
        "Improved application startup time by 30%",
        "Successfully launched 3 major apps in the App Store and Play Store"
      ],
    ),
    Experience(
      company: "Creative Apps Studio",
      role: "Flutter Developer",
      duration: "2022 — 2023",
      location: "Bhopal, India",
      responsibilities: [
        "Built custom UI components and animations using Flutter",
        "Collaborated with UI/UX designers to implement pixel-perfect designs",
        "Integrated third-party SDKs and payment gateways",
        "Maintained and updated existing Flutter projects to the latest SDK versions"
      ],
      technologies: ["Flutter", "Dart", "Provider", "SQLite", "Git"],
      achievements: [
        "Delivered a complete e-commerce solution in record time",
        "Implemented a highly efficient offline storage system using Hive"
      ],
    ),
  ];

  static final List<Project> projects = [
    Project(
      name: "FinTech Pro",
      description: "A comprehensive financial management application with real-time tracking.",
      problemSolved: "Helped users manage their personal finances with complex data visualization and secure transactions.",
      technologies: ["Flutter", "Firebase", "GetX", "Charts"],
      features: ["Expense Tracking", "Investment Portfolio", "Bill Reminders", "PDF Reports"],
      isFeatured: true,
      category: "Mobile",
      githubUrl: "https://github.com/kheamesh/fintech-pro",
      liveUrl: "https://fintech-pro.web.app",
    ),
    Project(
      name: "HealthConnect",
      description: "Bridging the gap between patients and doctors with seamless teleconsultation.",
      problemSolved: "Streamlined the appointment booking process and integrated secure video calling.",
      technologies: ["Flutter", "WebRTC", "Agora", "Node.js"],
      features: ["Video Consultation", "Digital Prescriptions", "Chat System", "Payment Integration"],
      isFeatured: true,
      category: "Mobile",
      githubUrl: "https://github.com/kheamesh/health-connect",
    ),
    Project(
      name: "E-Commerce Luxe",
      description: "A premium shopping experience with smooth transitions and high performance.",
      problemSolved: "Created a high-converting mobile storefront with advanced search and filtering.",
      technologies: ["Flutter Web", "REST API", "Riverpod", "Stripe"],
      features: ["Product Discovery", "Smart Cart", "Multi-currency support", "Admin Panel"],
      isFeatured: false,
      category: "Web",
    ),
    Project(
      name: "TaskMaster AI",
      description: "Smart task management utilizing AI for prioritization and scheduling.",
      problemSolved: "Reduced time spent on task organization by 40% through intelligent automation.",
      technologies: ["Flutter", "OpenAI API", "SQLite", "Provider"],
      features: ["AI Scheduling", "Voice Commands", "Cloud Sync", "Collaborative Boards"],
      isFeatured: false,
      category: "Mobile",
    ),
  ];

  static final List<SkillCategory> skillCategories = [
    SkillCategory(
      title: "Mobile Development",
      skills: [
        Skill(name: "Flutter", icon: AppIcons.flutter),
        Skill(name: "Dart", icon: AppIcons.dart),
        Skill(name: "Android", icon: AppIcons.android),
        Skill(name: "iOS", icon: AppIcons.ios),
      ],
    ),
    SkillCategory(
      title: "State Management",
      skills: [
        Skill(name: "GetX", icon: AppIcons.getx),
        Skill(name: "Provider", icon: AppIcons.provider),
        Skill(name: "Riverpod", icon: AppIcons.riverpod),
      ],
    ),
    SkillCategory(
      title: "Backend / API",
      skills: [
        Skill(name: "REST API", icon: AppIcons.api),
        Skill(name: "Dio", icon: AppIcons.http),
        Skill(name: "Firebase", icon: AppIcons.firebase),
        Skill(name: "Auth", icon: AppIcons.auth),
      ],
    ),
    SkillCategory(
      title: "Tools & Design",
      skills: [
        Skill(name: "Git", icon: AppIcons.gitAlt),
        Skill(name: "GitHub", icon: AppIcons.github),
        Skill(name: "Figma", icon: AppIcons.figma),
        Skill(name: "Postman", icon: AppIcons.postman),
      ],
    ),
  ];

  static final List<Service> services = [
    Service(
      title: "Mobile App Development",
      description: "Building high-performance, native-like mobile applications for both iOS and Android using Flutter.",
      icon: AppIcons.mobileApp,
    ),
    Service(
      title: "Web Development",
      description: "Creating responsive and fast web applications using Flutter Web for a consistent cross-platform experience.",
      icon: AppIcons.webApp,
    ),
    Service(
      title: "UI/UX Implementation",
      description: "Translating complex designs into pixel-perfect, interactive, and user-friendly Flutter interfaces.",
      icon: AppIcons.uiDesign,
    ),
    Service(
      title: "API Integration",
      description: "Seamlessly connecting Flutter applications with complex RESTful APIs and backend services.",
      icon: AppIcons.apiSync,
    ),
  ];

  static final List<Map<String, String>> processSteps = [
    {"title": "Understand", "desc": "Understand the business problem and requirements."},
    {"title": "Plan", "desc": "Plan architecture, UI and technical approach."},
    {"title": "Design", "desc": "Create clean and intuitive user experiences."},
    {"title": "Develop", "desc": "Build scalable and maintainable Flutter applications."},
    {"title": "Test", "desc": "Test performance, responsiveness and reliability."},
    {"title": "Deploy", "desc": "Release and maintain the application."},
  ];

  static final List<Map<String, String>> achievements = [
    {"title": "Production Apps", "value": "12+"},
    {"title": "API Integrations", "value": "50+"},
    {"title": "Performance Boost", "value": "40%"},
    {"title": "Happy Clients", "value": "20+"},
  ];

  static const String email = "kheamesh.soni@example.com";
  static const String github = "https://github.com/kheamesh";
  static const String linkedin = "https://linkedin.com/in/kheamesh";
  static const String location = "Bhopal, India";
}
