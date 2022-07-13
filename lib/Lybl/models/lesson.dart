import 'dart:convert';

class Lesson {
  String name;
  String intro;
  String practice;
  String modattempts;
  String usepassword;
  String custom;
  String ongoing;
  String review;
  String feedback;
  String retake;
  String mediafile;
  String slideshow;
  String bgcolor;
  String displayleft;
  String progressbar;
  String allowofflineattempts;
  String introfiles;
  int mediaclose;
  int displayleftif;
  int height;
  int width;
  int mediawidth;
  int mediaheight;
  int timelimit;
  int minquestions;
  int nextpagedefault;
  int maxpages;
  int maxattempts;
  int maxanswers;
  int usemaxgrade;
  int grade;
  int introformat;
  int course;
  int coursemodule;
  int id;
  List mediafiles;
  List warnings;
  String title;
  String contents;
  String get getName => this.name;

  set setName(String name) => this.name = name;

  get getIntro => this.intro;

  set setIntro(intro) => this.intro = intro;

  get getPractice => this.practice;

  set setPractice(practice) => this.practice = practice;

  get getModattempts => this.modattempts;

  set setModattempts(modattempts) => this.modattempts = modattempts;

  get getUsepassword => this.usepassword;

  set setUsepassword(usepassword) => this.usepassword = usepassword;

  get getCustom => this.custom;

  set setCustom(custom) => this.custom = custom;

  get getOngoing => this.ongoing;

  set setOngoing(ongoing) => this.ongoing = ongoing;

  get getReview => this.review;

  set setReview(review) => this.review = review;

  get getFeedback => this.feedback;

  set setFeedback(feedback) => this.feedback = feedback;

  get getRetake => this.retake;

  set setRetake(retake) => this.retake = retake;

  get getMediafile => this.mediafile;

  set setMediafile(mediafile) => this.mediafile = mediafile;

  get getSlideshow => this.slideshow;

  set setSlideshow(slideshow) => this.slideshow = slideshow;

  get getBgcolor => this.bgcolor;

  set setBgcolor(bgcolor) => this.bgcolor = bgcolor;

  get getDisplayleft => this.displayleft;

  set setDisplayleft(displayleft) => this.displayleft = displayleft;

  get getProgressbar => this.progressbar;

  set setProgressbar(progressbar) => this.progressbar = progressbar;

  get getAllowofflineattempts => this.allowofflineattempts;

  set setAllowofflineattempts(allowofflineattempts) =>
      this.allowofflineattempts = allowofflineattempts;

  get getIntrofiles => this.introfiles;

  set setIntrofiles(introfiles) => this.introfiles = introfiles;

  get getMediaclose => this.mediaclose;

  set setMediaclose(mediaclose) => this.mediaclose = mediaclose;

  get getDisplayleftif => this.displayleftif;

  set setDisplayleftif(displayleftif) => this.displayleftif = displayleftif;

  get getHeight => this.height;

  set setHeight(height) => this.height = height;

  get getWidth => this.width;

  set setWidth(width) => this.width = width;

  get getMediawidth => this.mediawidth;

  set setMediawidth(mediawidth) => this.mediawidth = mediawidth;

  get getMediaheight => this.mediaheight;

  set setMediaheight(mediaheight) => this.mediaheight = mediaheight;

  get getTimelimit => this.timelimit;

  set setTimelimit(timelimit) => this.timelimit = timelimit;

  get getMinquestions => this.minquestions;

  set setMinquestions(minquestions) => this.minquestions = minquestions;

  get getNextpagedefault => this.nextpagedefault;

  set setNextpagedefault(nextpagedefault) =>
      this.nextpagedefault = nextpagedefault;

  get getMaxpages => this.maxpages;

  set setMaxpages(maxpages) => this.maxpages = maxpages;

  get getMaxattempts => this.maxattempts;

  set setMaxattempts(maxattempts) => this.maxattempts = maxattempts;

  get getMaxanswers => this.maxanswers;

  set setMaxanswers(maxanswers) => this.maxanswers = maxanswers;

  get getUsemaxgrade => this.usemaxgrade;

  set setUsemaxgrade(usemaxgrade) => this.usemaxgrade = usemaxgrade;

  get getGrade => this.grade;

  set setGrade(grade) => this.grade = grade;

  get getIntroformat => this.introformat;

  set setIntroformat(introformat) => this.introformat = introformat;

  get getCourse => this.course;

  set setCourse(course) => this.course = course;

  get getCoursemodule => this.coursemodule;

  set setCoursemodule(coursemodule) => this.coursemodule = coursemodule;

  get getId => this.id;

  set setId(id) => this.id = id;

  get getMediafiles => this.mediafiles;

  set setMediafiles(mediafiles) => this.mediafiles = mediafiles;

  get getWarnings => this.warnings;

  set setWarnings(warnings) => this.warnings = warnings;

  get getTitle => this.title;

  set setTitle(title) => this.title = title;

  get getContents => this.contents;

  set setContents(contents) => this.contents = contents;
  Lesson(
    this.name,
    this.intro,
    this.practice,
    this.modattempts,
    this.usepassword,
    this.custom,
    this.ongoing,
    this.review,
    this.feedback,
    this.retake,
    this.mediafile,
    this.slideshow,
    this.bgcolor,
    this.displayleft,
    this.progressbar,
    this.allowofflineattempts,
    this.introfiles,
    this.mediaclose,
    this.displayleftif,
    this.height,
    this.width,
    this.mediawidth,
    this.mediaheight,
    this.timelimit,
    this.minquestions,
    this.nextpagedefault,
    this.maxpages,
    this.maxattempts,
    this.maxanswers,
    this.usemaxgrade,
    this.grade,
    this.introformat,
    this.course,
    this.coursemodule,
    this.id,
    this.mediafiles,
    this.warnings,
    this.title,
    this.contents,
  );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'intro': intro,
      'practice': practice,
      'modattempts': modattempts,
      'usepassword': usepassword,
      'custom': custom,
      'ongoing': ongoing,
      'review': review,
      'feedback': feedback,
      'retake': retake,
      'mediafile': mediafile,
      'slideshow': slideshow,
      'bgcolor': bgcolor,
      'displayleft': displayleft,
      'progressbar': progressbar,
      'allowofflineattempts': allowofflineattempts,
      'introfiles': introfiles,
      'mediaclose': mediaclose,
      'displayleftif': displayleftif,
      'height': height,
      'width': width,
      'mediawidth': mediawidth,
      'mediaheight': mediaheight,
      'timelimit': timelimit,
      'minquestions': minquestions,
      'nextpagedefault': nextpagedefault,
      'maxpages': maxpages,
      'maxattempts': maxattempts,
      'maxanswers': maxanswers,
      'usemaxgrade': usemaxgrade,
      'grade': grade,
      'introformat': introformat,
      'course': course,
      'coursemodule': coursemodule,
      'id': id,
      'mediafiles': mediafiles,
      'warnings': warnings,
      'title': title,
      'contents': contents,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      map['name'],
      map['intro'],
      map['practice'],
      map['modattempts'],
      map['usepassword'],
      map['custom'],
      map['ongoing'],
      map['review'],
      map['feedback'],
      map['retake'],
      map['mediafile'],
      map['slideshow'],
      map['bgcolor'],
      map['displayleft'],
      map['progressbar'],
      map['allowofflineattempts'],
      map['introfiles'],
      map['mediaclose'],
      map['displayleftif'],
      map['height'],
      map['width'],
      map['mediawidth'],
      map['mediaheight'],
      map['timelimit'],
      map['minquestions'],
      map['nextpagedefault'],
      map['maxpages'],
      map['maxattempts'],
      map['maxanswers'],
      map['usemaxgrade'],
      map['grade'],
      map['introformat'],
      map['course'],
      map['coursemodule'],
      map['id'],
      List.from(map['mediafiles']),
      List.from(map['warnings']),
      map['title'],
      map['contents'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) => Lesson.fromMap(json.decode(source));
}
