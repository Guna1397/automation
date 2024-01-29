package com.test.listeners;

import org.testng.ITestContext;
import org.testng.ITestListener;
import org.testng.ITestResult;
import com.aventstack.extentreports.ExtentReports;
import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.Status;

public class APITestListener implements ITestListener {

	ExtentReports extentReports;
	ExtentReport extentReport;
	ExtentTest extendTest;
//	ExtentReports extentSparkReporter;

	@Override
	public void onTestStart(ITestResult result) {
		String testName = result.getName();
		extendTest = extentReports.createTest(testName);
		extendTest.log(Status.INFO, "Starting API test: " + testName);
		System.out.println("Starting API test: " + testName);
	}

	@Override
	public void onTestSuccess(ITestResult result) {
		String testName = result.getName();
//		extendTest = extentReports.createTest(testName);
		extendTest.log(Status.PASS, "API test passed: " + testName);
		System.out.println("API test passed: " + testName);
	}

	@Override
	public void onTestFailure(ITestResult result) {
		String testName = result.getName();
//		extendTest = extentReports.createTest(testName);
		extendTest.log(Status.FAIL, "API test failed: " + testName);
		System.out.println("API test failed: " + testName);
	}

	@Override
	public void onTestSkipped(ITestResult result) {
		String testName = result.getName();
		extendTest.log(Status.SKIP, "API test skipped: " + testName);
		System.out.println("API test skipped: " + testName);
	}

	@Override
	public void onStart(ITestContext context) {
		extentReports = ExtentReport.extentReportSetUp();
	}

	@Override
	public void onFinish(ITestContext context) {
//		String testName = context.getName();
		extentReports.flush();
//		extendTest.log(Status.INFO, "API test Completed: ");
	}

}
