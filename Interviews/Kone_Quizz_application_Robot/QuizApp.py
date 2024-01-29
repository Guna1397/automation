import random
import json


db = open("DataBase.json")
data = json.load(db)
print(data)


questions = data

def dummy():
    return data

def add_question( question, answer):
    questions[question] = answer
    return questions


def delete_question( question):
    if question in questions:
        del questions[question]
    return questions


def display_questions():
    # if not self.questions:
    for question, answer in questions.items():
        print(f"Q: {question}")
        print(f"A: {answer}\n")
    return questions


def start_game():
    score = 0
    if not questions:
        print("No questions available. Please add questions to start the game.")
        return

    print("Starting the quiz game!")
    available_questions = list(questions.keys())
    random.shuffle(available_questions)

    for i in range(len(questions)):
        current_question = available_questions[i]
        user_answer = input(f"\nQ: {current_question}\nYour Answer: ").strip()

        if user_answer.lower() == questions[current_question].lower():
            print("Correct!\n")
            score += 1
        else:
            print(f"Wrong! The correct answer is: {questions[current_question]}\n")

    print(f"Game Over! Your score: {score}/{len(questions)}")
choice = ("Enter your choice (1/2/3/4/5): ").strip()
def whilefun(choice):
    while True:
        print("\nMenu:")
        print("1. Add Question and Answer")
        print("2. Delete Question and Answer")
        print("3. Display Questions and Answers")
        print("4. Start Game")
        print("5. Quit")

        # choice = input("Enter your choice (1/2/3/4/5): ").strip()

        if choice == '1':
            question = input("Enter the question: ").strip()
            answer = input("Enter the answer: ").strip()
            add_question(question, answer)
            print("Question and answer added successfully.")

        elif choice == '2':
            question = input("Enter the question to delete: ").strip()
            delete_question(question)
            print("Question and answer deleted successfully.")

        elif choice == '3':
            display_questions()

        elif choice == '4':
            start_game()

        elif choice == '5':
            print("Goodbye!")
            break

        else:
            return "Invalid choice. Please select a valid option."


