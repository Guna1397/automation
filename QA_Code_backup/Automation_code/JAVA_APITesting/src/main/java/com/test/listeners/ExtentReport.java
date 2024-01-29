package com.test.listeners;

import java.io.File;

import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.reporter.ExtentSparkReporter;
import com.aventstack.extentreports.reporter.configuration.Theme;

public class ExtentReport {

	public static ExtentReports extentReportSetUp() {
		ExtentReports extentReports = new ExtentReports();
		File extentreportFile = new File(System.getProperty("user.dir") + "\\test-output\\ExtentReports\\extentReports.html");
		ExtentSparkReporter extentSparkReporter = new ExtentSparkReporter(extentreportFile);
//        extent = new ExtentReports();
//		extentSparkReporter.config().setTheme(Theme.DARK);
//		extentSparkReporter.config().setReportName("API Test Automation Report");
//		extentSparkReporter.config().setDocumentTitle("Automation Report");
//		extentSparkReporter.config().setTimeStampFormat("dd/MM/YYYY hh:mm:ss");
		extentReports.attachReporter(extentSparkReporter);
		return extentReports;
	}

}
