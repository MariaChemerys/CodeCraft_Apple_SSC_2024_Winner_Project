
import Foundation

struct TextBlocksContent: Identifiable{
    
    // English Language
    var contentENG: String = "placeholder"
    
    // Ukrainian Language
    var contentUA: String = "місцезаймач"
    
    var id: Int
    
}

class TextBlocksContentViewModel{
    
    static let instance = TextBlocksContentViewModel()
    
    // ComicView
    var comicContent = [
        TextBlocksContent(
            contentENG: "It’s hard to believe what’s now happening in CodeCraft, the world of programming concepts created by programmers’ imagination.",
            contentUA: "Складно повірити в те, що зараз відбувається в КодКрафті, світі концептів програмування створеному уявою програмістів.",
            id: 0),
        TextBlocksContent(
            contentENG: "We will ask Ada Lovelace, the first computer programmer and the founder of CodeCraft, about the potential hazards and solutions.",
            contentUA: "Ми запитаємо Аду Лавлейс, першого комп'ютерного програміста, про потенційні загрози та рішення.",
            id: 1),
        TextBlocksContent(
            contentENG: "As you see, the images of famous programmers have disappeared from the screens of the Museum of Prominent Programmers. If we don’t build a program to restore them, these people will be forgotten by humanity forever.",
            contentUA: "Як бачите, зображення відомих програмістів зникли з екранів Музею видатних програмістів. Якщо ми не створимо програму для їх відновлення, ці люди будуть забуті навіки.",
            id: 2),
        TextBlocksContent(
            contentENG: "This means that the younger generation will never get inspired by their accomplishments, and much less programming concepts will be born in CodeCraft. But luckily, I already see the hero who can help us to save our world!",
            contentUA: "Це значить, що молоде покоління ніколи не надихнеться їх досягненнями, та значно менше концептів програмування народиться у КодКрафті. Але, на щастя, я вже бачу героя, який зможе допомогти нам врятувати наш світ!",
            id: 3),
    ]
    
    // SettingsView
    var settingsContent = [
        TextBlocksContent(
            contentENG: "Settings",
            contentUA: "Налаштування",
            id: 0),
        TextBlocksContent(
            contentENG: "Language",
            contentUA: "Мова",
            id: 1),
        TextBlocksContent(
            contentENG: "Speaking rate",
            contentUA: "Швидкість озвучування",
            id: 2),
        TextBlocksContent(
            contentENG: "Increase contrast",
            contentUA: "Збільшити контраст",
            id: 3),
    ]
    
    // IntroView
    var introContent = [
        TextBlocksContent(
            contentENG: "Have you ever played the Color by Number game? In this game, you can turn a grid of numbers that correspond to particular colors into a beautiful picture. This is usually done using the key that shows which number represents which color.",
            contentUA: "Ти знаєш гру \"Зафарбуй за номером\"? У цій грі ти можеш перетворити числову сітку які відповідають певним кольорам на красиву картинку. Це зазвичай роблять використовуючи ключ, що показує яке число відповідає якому кольору.",
            id: 0
        ),
        TextBlocksContent(
            contentENG: "For safety reasons, I created files with color-by-number grids and their keys for the images of famous programmers. Our task is to build a program that will restore the images using these files. We will need programming concepts to reach our goal. Let’s start with variables!",
            contentUA: "З причин безпеки, я створила файли з числовими сітками та їх ключами для зображень знаменитих програмістів. Наше завдання - створити програму, яка відновить зображення, використовуючи ці файли. Нам знадобляться концепти програмування, щоб досягти нашої цілі. Розпочнімо зі змінних!",
            id: 1
        ),
        TextBlocksContent(
            contentENG: "Programming Concepts",
            contentUA: "Концепти програмування",
            id: 2
        ),
        TextBlocksContent(
            contentENG: "Variables",
            contentUA: "Змінні",
            id: 3
        ),
        TextBlocksContent(
            contentENG: "Arrays",
            contentUA: "Масиви",
            id: 4
        ),
        TextBlocksContent(
            contentENG: "Loops",
            contentUA: "Цикли",
            id: 5
        ),
        TextBlocksContent(
            contentENG: "Functions",
            contentUA: "Функції",
            id: 6
        )
    ]
    
    // VariablesView
    var variablesContent = [
        TextBlocksContent(
            contentENG: "Hello, we are variables! Each of us has a data type and a name. For example, I am a variable of type Integer, and my name is “number”. We all store values of our data types. Press the button with a lock icon on the screen to see them.",
            contentUA: "Привіт, ми - змінні! Кожна з нас має тип даних та ім'я. Наприклад, я змінна типу Integer (ціле число), та моє ім'я - number (число). Ми всі зберігаємо значення наших типів даних. Натисни на кнопку з іконкою замку на екрані, щоб побачити їх.",
            id: 0
        ),
        TextBlocksContent(
            contentENG: "Good job! Ada has prepared files with number grids and their keys that your program will have to access. Therefore, you need two variables (keyFileName and gridFileName) to store their names. Pass the names of the files to the variables using the button with a paperplane icon.",
            contentUA: "Хороша робота! Ада приготувала файли з числовими сітками та їх ключами, до яких має отримати доступ твоя програма. Тому тобі потрібні дві змінні, щоб зберегти їх імена: keyFileName (ім'я файлу з ключем) та gridFileName (ім'я файлу з сіткою). Передай імена файлів змінним за допомогою кнопки з іконкою паперового літачка.",
            id: 1
        )
    ]
    
    //LoopArrayView
    var loopArrayContent = [
        TextBlocksContent(
            contentENG: "Hi, I am an array, and the guy on the right is my best friend loop. My name is arrayOfNumbers. Unlike simple variables that can store only one value, I am capable of storing many values of one data type (in my case, Integer). Press the button with a lock icon to see them.",
            contentUA: "Здоров, я масив, а хлопець зліва - мій найкращий друг loop (цикл). Моє ім'я - arrayOfNumbers (масив чисел). На відміну від звичайних змінних, які можуть зберігати лише одне значення, я здатний зберігати багато значень одного типу даних (у моєму випадку, Integer). Натисни на кнопку, щоб побачити їх.",
            id: 0
        ),
        TextBlocksContent(
            contentENG: "Loop can iterate through my elements (take them one by one). This is useful for performing some operation on each element of an array. Press the button with circular arrows to witness that.",
            contentUA: "Цикл може ітерувати мої елементи (брати їх один за одним). Це корисно для виконання певних операцій над кожним елементом масиву. Натисни на кнопку з круглими стрілочками, щоб побачити, як він це робить.",
            id: 1
        )
    ]
    
    // FunctionsView
    var functionsContent = [
        TextBlocksContent(
            contentENG: "Hello, I am a function named fileToArray(). Functions can take variables, perform some operations on them, and return the result. For example, I may take the gridFileName variable to access the file with the number grid and return the grid to an array. In this way, these data will be stored properly in the program. Please pass me the gridFileName variable.",
            contentUA: "Привіт, я функція fileToArray() (файл в масив). Функції можуть приймати змінні, здійснювати операції над ними та повертати результат. Наприклад, я можу взяти змінну gridFileName (ім'я файлу з сіткою), щоб отримати доступ до файлу з числовою сіткою та повернути її в масив. Таким чином, ці дані будуть надійно збережені в програмі. Будь ласка, передай мені змінну gridFileName.",
            id: 0
        ),
        TextBlocksContent(
            contentENG: "Nice, let’s do the final step to finish the program! I am the numberToColor() function. Loop can help me to get the numbers from the number grid one by one. Using the key, I will learn which color represents which number and turn the grid into an image. Pass me the numberGrid array and the keyFileName variable.",
            contentUA: "Добре, зробімо останній крок, щоб завершити програму! Я - функція numberToColor() (число в колір). Цикл може допомогти мені дістати числа з числової сітки одне за одним. За допомогою ключа я дізнаюся, яке число відповідає якому кольору та перетворю сітку на зображення. Передай мені масив numberGrid (числова сітка) та змінну keyFileName (ім'я файлу з ключем).",
            id: 1
        )
    ]
    
    // EndingView
    var endingContent = [
        TextBlocksContent(
            contentENG: "Congratulations! Your program has restored the images of famous programmers. You can learn about their achievements by pressing the info button on the screens. I hope that after saving CodeCraft you will be happy to continue your programming journey. Can’t wait to see your photo in our museum!",
            contentUA: "Вітаю! Твоя програма відновила зображення відомих програмістів. Ти можеш дізнатися про їх досягнення, натиснувши інфо-кнопку. Сподіваюся, що після порятунку КодКрафту ти з радістю продовжиш займатися програмуванням. З нетерпінням чекаю дня, коли побачу твоє фото в нашому музеї!",
            id: 0
        ),
        TextBlocksContent(
            contentENG: "Margaret Hamilton",
            contentUA: "Маргарет Гамільтон",
            id: 1
        ),
        TextBlocksContent(
            contentENG: "Alan Turing",
            contentUA: "Алан Тюринг",
            id: 2
        ),
        TextBlocksContent(
            contentENG: "Grace Hopper",
            contentUA: "Ґрейс Гоппер",
            id: 3
        ),
        TextBlocksContent(
            contentENG: "Margaret Hamilton was a NASA software engineer who developed the onboard flight software that played a critical role in the success of the Apollo 11 moon landing in 1969.",
            contentUA: "Маргарет Гамільтон була програмістом в NASA. Вона створювала програми для літальних апаратів, що відіграло критичну роль в приземленні на місяць Apollo 11 у 1969.",
            id: 4
        ),
        TextBlocksContent(
            contentENG: "Alan Turing introduced the stored program concept, where instructions and data are stored in a computer's memory, which is fundamental to modern programming languages.",
            contentUA: "Алан Тюринг створив концепт збереженої програми, де інструкції та дані зберігалися разом у пам'яті комп'ютера, що є основним для сучасних мов програмування.",
            id: 5
        ),
        TextBlocksContent(
            contentENG: "Grace Hopper developed COBOL, one of the first high-level programming languages. It resembled English, which made programming accessible to a broader audience.",
            contentUA: "Ґрейс Гоппер розробила високорівневу мову програмування COBOL. Вона була схожа на англійську, що зробило програмування доступним для ширшої аудиторії.",
            id: 6
        ),
        TextBlocksContent(
            contentENG: "Do you want to restart the game?",
            contentUA: "Ти хочеш перезапустити гру?",
            id: 7
        ),
    ]
}

