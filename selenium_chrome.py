import os
import sys
sys.path.insert(0, "/cygdrive/c/python27/lib/site-packages/")
from selenium import webdriver

# fp = webdriver.FirefoxProfile()
options = webdriver.ChromeOptions() 
options.add_argument("download.default_directory=/tmp")

browser = webdriver.Chrome(chrome_options=options)
# fp.set_preference("browser.download.folderList",2)
# fp.set_preference("browser.download.manager.showWhenStarting",False)
# fp.set_preference("browser.download.dir", os.getcwd())
# fp.set_preference("browser.helperApps.neverAsk.saveToDisk", "application/octet-stream")

# browser = webdriver.Firefox(firefox_profile=fp)
browser.get("http://pypi.python.org/pypi/selenium")
browser.find_element_by_link_text("selenium-3.10.0.tar.gz").click()

